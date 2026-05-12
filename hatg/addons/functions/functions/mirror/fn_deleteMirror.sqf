/*
    Author:
        Silence
    
    Description:
        Deletes _mirror and removes it from the _unit namespace
    
    Params:
        _unit <OBJECT> <Default: ObjNull>
        _mirror <OBJECT> <Default: ObjNull>
    
    Dependencies:
        N/A

    Scope:
        Local, Remote
    
    Environment:
        Unscheduled
    
    Usage:
        [player] call HATG_fnc_NAME;
    
    Return:
        _return <TYPE>
*/

params [
    ["_unit", ObjNull],
    ["_mirror", ObjNull]
];

if (_mirror isEqualTo ObjNull) then {
    _mirror = [_unit] call HATG_fnc_getMirror
};

if (_unit isEqualTo ObjNull) exitWith {false};
if (_mirror isEqualTo ObjNull) exitWith {false}; // if mirror is still ObjNull then we can assume it does not exist

[format["Deleting a mirror at position (ATL: %1)", getPosATL _mirror], 1, _fnc_scriptName] call HATG_fnc_log;

// //deleteVehicle _mirror;
// _mirror hideObject true;
// _mirror hideObjectGlobal true;
// //_unit setVariable ["hatg_mirror", ObjNull, true];

// 检查 toggle 状态：如果开启，真正删除 mirror；否则只是隐藏
// heck the toggle state: if on, permanently delete the mirror; otherwise, only hide it.
private _toggle = ["hatg_mirror_toggle", false, _unit] call HATG_fnc_getVariable;
if (_toggle) then {
    deleteVehicle _mirror;
    _unit setVariable ["hatg_mirror", ObjNull, true];
    //_unit setVariable ["hatg_mirror_visible", false, true];
    ["Mirror deleted due to toggle", 1, _fnc_scriptName] call HATG_fnc_log;
} else {
    _mirror hideObject true;
    _mirror hideObjectGlobal true;
    _unit setVariable ["hatg_mirror_visible", false, true];
};

if (isPlayer _unit) then {
    [_unit] call HATG_fnc_handleDisplayText;
};

true;
