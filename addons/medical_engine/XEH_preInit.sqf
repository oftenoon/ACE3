#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initSettings.sqf"

// Define "Constants" variables (both are macros defined in script_macros_medical.hpp, look there for actual variable names)
if (isNil QUOTE(HEAD_DAMAGE_THRESHOLD)) then {HEAD_DAMAGE_THRESHOLD = HEAD_DAMAGE_THRESHOLD_DEFAULT};
if (isNil QUOTE(ORGAN_DAMAGE_THRESHOLD)) then {ORGAN_DAMAGE_THRESHOLD = ORGAN_DAMAGE_THRESHOLD_DEFAULT};
if (isNil QUOTE(HEART_HIT_CHANCE)) then {HEART_HIT_CHANCE = HEART_HIT_CHANCE_DEFAULT};
if (isNil QUOTE(PENETRATION_THRESHOLD)) then {PENETRATION_THRESHOLD = PENETRATION_THRESHOLD_DEFAULT};
if (isNil QUOTE(BLOOD_LOSS_KNOCK_OUT_THRESHOLD)) then {BLOOD_LOSS_KNOCK_OUT_THRESHOLD = BLOOD_LOSS_KNOCK_OUT_THRESHOLD_DEFAULT};
if (isNil QUOTE(PAIN_UNCONSCIOUS)) then {PAIN_UNCONSCIOUS = PAIN_UNCONSCIOUS_DEFAULT};
if (isNil QUOTE(PAIN_FADE_TIME)) then {PAIN_FADE_TIME = PAIN_FADE_TIME_DEFAULT};
if (isNil QUOTE(LIMPING_DAMAGE_THRESHOLD)) then {LIMPING_DAMAGE_THRESHOLD = LIMPING_DAMAGE_THRESHOLD_DEFAULT};
if (isNil QUOTE(FRACTURE_DAMAGE_THRESHOLD)) then {FRACTURE_DAMAGE_THRESHOLD = FRACTURE_DAMAGE_THRESHOLD_DEFAULT};
// Derive the alternate fatal damage coefficents
if (isNil QUOTE(FATAL_SUM_DAMAGE_WEIBULL_K) || isNil QUOTE(FATAL_SUM_DAMAGE_WEIBULL_L)) then {
    private _x1 = 0.5;
    private _y1 = 0.1;
    private _x2 = 0.8;
    private _y2 = 0.9;
    private _b1 = -ln (1-_y1);
    private _b2 = -ln (1-_y2);
    FATAL_SUM_DAMAGE_WEIBULL_K = ln(_b1/_b2) / ln(_x1/_x2);
    FATAL_SUM_DAMAGE_WEIBULL_L = _x1 / _b1^(1/FATAL_SUM_DAMAGE_WEIBULL_K);
};

// Cache for armor values of equipped items (vests etc)
GVAR(armorCache) = false call CBA_fnc_createNamespace;

// Hack for #3168 (units in static weapons do not take any damage):
// Doing a manual pre-load with a small distance seems to fix the LOD problems
// with handle damage not returning full results.
GVAR(fixedStatics) = [];

GVAR(animations) = [] call CBA_fnc_createNamespace;
GVAR(animations) setVariable [QGVAR(faceUp_unconscious), ["ace_unconscious_2","ace_unconscious_2_1","ace_unconscious_7_1","ace_unconscious_8_1","ace_unconscious_5_1","ace_unconscious_6_1"]];
GVAR(animations) setVariable [QGVAR(faceDown_unconscious), ["ace_unconscious_1", "ace_unconscious_3", "ace_unconscious_4","unconscious","ace_unconscious_9","ace_unconscious_3_1","ace_unconscious_4_1"]];
GVAR(animations) setVariable [QGVAR(faceLeft_unconscious), ["ace_unconscious_7","ace_unconscious_8","ace_unconscious_1_1","ace_unconscious_7_1","ace_unconscious_8_1"]];
GVAR(animations) setVariable [QGVAR(faceRight_unconscious), ["ace_unconscious_5","ace_unconscious_6","ace_unconscious_10","ace_unconscious_5_1","ace_unconscious_6_1"]];

private _fnc_fixStatic = {
    params ["_vehicle"];
    private _type = typeOf _vehicle;

    if !(_type in GVAR(fixedStatics)) then {
        GVAR(fixedStatics) pushBack _type;
        PRELOAD_CLASS(_type);
    };
};

["StaticWeapon", "init", _fnc_fixStatic] call CBA_fnc_addClassEventHandler;
["Car", "init", _fnc_fixStatic] call CBA_fnc_addClassEventHandler;

addMissionEventHandler ["Loaded", {
    {
        PRELOAD_CLASS(_x);
    } forEach GVAR(fixedStatics);
}];

["ace_unconscious", {
    params ["_unit", "_active"];
    if (_active) then {
        // Use object reference to indicate the waitUnit is already running (this prevents issues with respawning units keeping SetVars)
        if ((_unit getVariable [QGVAR(waitForAnim), objNull]) == _unit) exitWith {};
        _unit setVariable [QGVAR(waitForAnim), _unit];
        [{(animationState _this) find QGVAR(face) != -1}, {
            [_this, animationState _this] call FUNC(applyAnimAfterRagdoll);
        }, _unit, 20] call CBA_fnc_waitUntilAndExecute;
    } else {
        _unit setVariable [QGVAR(waitForAnim), nil];
        if (local _unit) then {
            [_unit, _active] call FUNC(setUnconsciousAnim);
        };
    };
}] call CBA_fnc_addEventhandler;

[] call FUNC(disableThirdParty);

ADDON = true;
