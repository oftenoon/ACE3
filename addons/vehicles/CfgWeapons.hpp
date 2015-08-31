
class CfgWeapons {
    class MGunCore;
    class MGun: MGunCore {};
    class LMG_RCWS: MGun {};

    class LMG_coax;
    class ACE_LMG_coax_MBT_01: LMG_coax {};
    class ACE_LMG_coax_APC_Tracked_03: LMG_coax {};

    class LMG_Minigun: LMG_RCWS {
        magazines[] = {"1000Rnd_65x39_Belt","1000Rnd_65x39_Belt_Green","1000Rnd_65x39_Belt_Tracer_Green","1000Rnd_65x39_Belt_Tracer_Red","1000Rnd_65x39_Belt_Tracer_Yellow","1000Rnd_65x39_Belt_Yellow","2000Rnd_65x39_Belt","2000Rnd_65x39_Belt_Green","2000Rnd_65x39_Belt_Tracer_Green","2000Rnd_65x39_Belt_Tracer_Green_Splash","2000Rnd_65x39_Belt_Tracer_Red","2000Rnd_65x39_Belt_Tracer_Yellow","2000Rnd_65x39_Belt_Tracer_Yellow_Splash","2000Rnd_65x39_Belt_Yellow","2000Rnd_762x51_Belt_T_Green","2000Rnd_762x51_Belt_T_Red","2000Rnd_762x51_Belt_T_Yellow","200Rnd_65x39_Belt","200Rnd_65x39_Belt_Tracer_Green","200Rnd_65x39_Belt_Tracer_Red","200Rnd_65x39_Belt_Tracer_Yellow","5000Rnd_762x51_Belt","5000Rnd_762x51_Yellow_Belt"};

        class manual: MGun {
            reloadTime = 0.015;
            dispersion = 0.006;
        };
        class close: manual {};
        class short: close {};
        class medium: close {};
        class far: close {};
    };

    class HMG_127: LMG_RCWS {
        class manual: MGun {};
    };

    class HMG_01: HMG_127 {
        reloadTime = 0.23;

        class manual: manual {
            reloadTime = 0.23;
        };
        class close: manual {
            reloadTime = 0.23;
        };
        class short: close {
            reloadTime = 0.23;
        };
        class medium: close {
            reloadTime = 0.23;
        };
        class far: close {
            reloadTime = 0.23;
        };
    };

    class autocannon_Base_F;
    class autocannon_30mm_CTWS: autocannon_Base_F {
        class AP: autocannon_Base_F {
            magazines[] = {"60Rnd_30mm_APFSDS_shells","60Rnd_30mm_APFSDS_shells_Tracer_Red","60Rnd_30mm_APFSDS_shells_Tracer_Green","60Rnd_30mm_APFSDS_shells_Tracer_Yellow","140Rnd_30mm_MP_shells","140Rnd_30mm_MP_shells_Tracer_Red","140Rnd_30mm_MP_shells_Tracer_Green","140Rnd_30mm_MP_shells_Tracer_Yellow"};
            magazineReloadTime = 0;
        };

        muzzles[] = {"AP"};
    };
    class autocannon_40mm_CTWS: autocannon_Base_F {
        class AP: autocannon_Base_F {
            magazines[] = {"40Rnd_40mm_APFSDS_shells","40Rnd_40mm_APFSDS_Tracer_Red_shells","40Rnd_40mm_APFSDS_Tracer_Green_shells","40Rnd_40mm_APFSDS_Tracer_Yellow_shells","60Rnd_40mm_GPR_shells","60Rnd_40mm_GPR_Tracer_Red_shells","60Rnd_40mm_GPR_Tracer_Green_shells","60Rnd_40mm_GPR_Tracer_Yellow_shells"};
            magazineReloadTime = 0;
        };

        muzzles[] = {"AP"};
    };

    // make static weapons compatible with 100rnd mag variants
    class HMG_static: HMG_01 {
        magazines[] = {"500Rnd_127x99_mag","500Rnd_127x99_mag_Tracer_Red","500Rnd_127x99_mag_Tracer_Green","500Rnd_127x99_mag_Tracer_Yellow","200Rnd_127x99_mag","200Rnd_127x99_mag_Tracer_Red","200Rnd_127x99_mag_Tracer_Green","200Rnd_127x99_mag_Tracer_Yellow","100Rnd_127x99_mag","100Rnd_127x99_mag_Tracer_Red","100Rnd_127x99_mag_Tracer_Green","100Rnd_127x99_mag_Tracer_Yellow"};
    };
};
