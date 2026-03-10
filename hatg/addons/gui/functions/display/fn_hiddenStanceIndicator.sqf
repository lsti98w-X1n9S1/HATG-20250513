/*
	Params:
		ARRAY - RGBA colour
	Example:
		[[1, 0, 0, 1]] call TAG_fnc_stanceIndicatorColor;
*/
disableSerialization;

params [
	["_color", [1, 1, 1, 1], [[]]]
];

private _display = uiNamespace getVariable ["RscStanceInfo", displayNull];
if (isNull _display) then {
	_display = findDisplay 303;
};
if (isNull _display) exitWith {controlNull};

private _control = _display displayCtrl 188;
if (isNull _control) exitWith {controlNull};

_control ctrlSetTextColor _color;
_control ctrlShow true;

_control
