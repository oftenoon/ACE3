#include "script_component.hpp"
/*
 * Author: xrufix, Glowbal
 * Handle set AimCoef calls. Will use the highest available setting.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Unique ID <STRING>
 * 2: Aim coefficient (a higher value causes more shaking) <NUMBER>
 * 3: Add (true) or remove (false) <BOOL> (default: true)
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "ace_advanced_fatigue", 1, true] call ace_common_fnc_setAimCoef
 *
 * Public: Yes
 */

ACE_DEPRECATED(QFUNC(setAimCoef),"3.13.0","ACE_setCustomAimCoef and arithmeticSetSource");
if (true) exitWith {};

params ["_unit", "_id", "_setting", ["_add", true]];

if (_add) then {
    private _settingCode = compile str _setting;
    [missionNamespace, "ACE_setCustomAimCoef", _id, _settingCode] call FUNC(arithmeticSetSource);
} else {
    [missionNamespace, "ACE_setCustomAimCoef", _id, {}] call FUNC(arithmeticSetSource);
};

private _aimCoef = [missionNamespace, "ACE_setCustomAimCoef", "max"] call EFUNC(common,arithmeticGetResult);
_unit setCustomAimCoef _aimCoef;
