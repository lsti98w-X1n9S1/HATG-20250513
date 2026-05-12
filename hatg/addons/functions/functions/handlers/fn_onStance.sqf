/*
    Author:
        Silence
    
    Description:
        The associated code with "handleStance"
    
    Params:
        _unit <OBJECT>
    
    Dependencies:
        missionNamespace variables:
        > "hatg_mirror_disable" <BOOL>
    
    Usage:
        [player] call HATG_fnc_onStance;
    
    Return:
        true, if we should exit
*/

params ["_unit"];

if !(alive _unit) exitWith {true};
if (["hatg_mirror_disable", false, _unit] call HATG_fnc_getVariable isEqualTo true) exitWith {true};

private _stance = stance _unit;
private _stances = ["PRONE", "STAND"];

if (hatg_setting_enable_crouch) then {
    _stances pushBack "CROUCH";
};

// if !(_stance in _stances) exitWith {[_unit] call HATG_fnc_deleteMirror; false};

// if ([_unit, _stance] call HATG_fnc_canCreateMirror) exitWith {
//     [_unit] call HATG_fnc_createMirror;
//     false;
// };

// [_unit] call HATG_fnc_deleteMirror;


if !(_stance in _stances) exitWith {
    // 已经是隐藏状态就不重复调用
    // If already hidden, do not call again
    if (_unit getVariable ["hatg_mirror_visible", false]) then {
        [_unit] call HATG_fnc_deleteMirror;
    };
    false
};

if ([_unit, _stance] call HATG_fnc_canCreateMirror) exitWith {
    // 已经是显示状态就不重复调用
    // If already visible, do not call again
    if !(_unit getVariable ["hatg_mirror_visible", false]) then {
        [_unit] call HATG_fnc_createMirror;
    };
    false;
};

// 已经是隐藏状态就不重复调用
// If already hidden, do not call again
if (_unit getVariable ["hatg_mirror_visible", false]) then {
    [_unit] call HATG_fnc_deleteMirror;
};

false;
