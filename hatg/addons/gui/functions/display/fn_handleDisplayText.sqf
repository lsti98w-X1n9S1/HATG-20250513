#include "..\..\script_component.hpp"
params ["_unit"];

private _display = call HATG_fnc_getDisplay;

if (_display isEqualTo []) exitWith {};

private _statusText = localize "$STR_HATG_Revealed";
private _displayHidden = _display#1;

private _textSize = hatg_setting_ui_textsize;
private _displayColourHidden = hatg_setting_ui_colour_hidden;
private _displayColourRevealed = hatg_setting_ui_colour_revealed;
private _displayImage = QPATHTOFOLDER(data\ui\revealed_ca.paa);

private _colour = _displayColourRevealed;

private _mirrorToggled = ["hatg_mirror_toggle", false, _unit] call HATG_fnc_getVariable;

if (!hatg_setting_ui && !_mirrorToggled) exitWith {
    private _hiddenText = "";
    _displayHidden ctrlSetStructuredText (parseText _hiddenText);
    _displayHidden ctrlCommit 0;
};

if (_mirrorToggled) then {
    _statusText = localize "$STR_HATG_Disabled";
    _displayImage = QPATHTOFOLDER(data\ui\disabled_ca.paa);
};

if (["hatg_mirror", ObjNull, _unit] call HATG_fnc_getVariable isNotEqualTo ObjNull) then {
    _colour = _displayColourHidden;
    _statusText = localize "$STR_HATG_Hidden";
    _displayImage = QPATHTOFOLDER(data\ui\hidden_ca.paa);
};

private _colourRGBA = _colour;
_colour = (_colour call BIS_fnc_colorRGBAtoHTML);

private _hiddenText = "";

switch (hatg_setting_ui_mode) do {
    case "Text": {
        _hiddenText = format [
            "<t shadow='1' font='%3' align='center' size='%2' color='%1'>%4</t>",
            _colour,
            _textSize,
            hatg_setting_ui_font,
            _statusText
        ];
    };
    case "Image": {
        _hiddenText = format [
            "<img align='center' shadow='0' color='%3' size='%1' image='%2' /><br />",
            _textSize * 2,
            _displayImage,
            _colour
        ];
    };
    case "Stance Indicator": {
        [_colourRGBA, true] call HATG_fnc_hiddenStanceIndicator;
    };
    default {
        _hiddenText = "";
    };
};

_displayHidden ctrlSetStructuredText (parseText _hiddenText);
_displayHidden ctrlSetFade 0;
_displayHidden ctrlCommit 0;

if (hatg_setting_ui_fade > 0) then {
    _displayHidden ctrlSetFade 1;
    _displayHidden ctrlCommit hatg_setting_ui_fade;
};