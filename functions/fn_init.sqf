#include "..\script_component.hpp"

#define punchDamage 0.15
#define knifeDamage 0.25

fn_fox_canInterrogate = {

	_obj = _this select 0;

	_can = _obj getVariable ["fox_interrogation_action", false];

	if(_can AND (alive _obj) )then{
			true
		}else{
			false
		};

};

fn_fox_punch = {

	_obj = _this select 0;
	_part = _this select 1;

	[_obj,punchDamage,_part,"stab"] call fn_fox_setDamage;

	[_obj] call fn_fox_sayDefaultText;

//[this,"SIT1", "ASIS"] call BIS_fnc_ambientAnim;
	//[[_veh],"fn_fox_knockedOn"] call BIS_fnc_MP;

	[_obj] spawn{

		_o = _this select 0;
		_o setRandomLip true;
		[_o,"hurt2"] call fn_fox_say3d;
		sleep 2;
		_o setRandomLip false;

	};


	//player switchmove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";
	[player,"AwopPercMstpSgthWnonDnon_end"] call fn_fox_switchMove;

	_oldrate = _obj getVariable ["fox_interrogation_rate", 0];
	_rate = _oldrate + (punchDamage * 100);
	_obj setVariable ["fox_interrogation_rate", _rate,true];

};

fn_fox_knife = {

	_obj = _this select 0;
	_part = _this select 1;

	[_obj,knifeDamage,_part,"stab"] call fn_fox_setDamage;

	[_obj] call fn_fox_sayDefaultText;


	[_obj] spawn{

		_o = _this select 0;
		_o setRandomLip true;
		[_o,"hurt1"] call fn_fox_say3d;
		sleep 2;
		_o setRandomLip false;


	};

	[player,"AwopPercMstpSgthWnonDnon_end"] call fn_fox_switchMove;

	_oldrate = _obj getVariable ["fox_interrogation_rate", 0];
	_rate = _oldrate + (knifeDamage * 100);
	_obj setVariable ["fox_interrogation_rate", _rate,true];

};

fn_fox_chairCheck = {

	_obj = _this select 0;
	_isAvailable = nearestObjects [_obj, ["Land_CampingChair_V2_F"], 4];

	if( ( count(_isAvailable) > 0 ) AND ( alive _obj ) )then{
		true
	}else{
		false
	};

};

fn_fox_chair = {

	_obj = _this select 0;
	_isAvailable = nearestObjects [_obj, ["Land_CampingChair_V2_F"], 3];

	_chair = selectRandom _isAvailable;

	_d = getDir _chair;
	_pos = getPos _chair;

	_obj setPos _pos;
	_obj setDir _d - 180;

	[_obj,"hubsittingchaira_idle1"] call fn_fox_switchMove;

	//[_obj,"SIT1", "ASIS"] call BIS_fnc_ambientAnim;

};

fn_fox_setDamage = {

	_obj = _this select 0;
	_damage = _this select 1;
	_part = _this select 2;
	_wound = _this select 3;


	//[_obj, _part, _damage, objNull, _wound, 0,objNull,_damage ] call ace_medical_fnc_handleDamage_advanced;


	[_obj, _part, _damage, objNull, _wound, 0, objNull ] call ACE_medical_fnc_handleDamage

	/*
	* [_obj, _part, 0, objNull, _wound, 0, _damage ] call ace_medical_fnc_handleDamage_advanced;
	*/

	/*
 * fnc_handleDamage_advanced.sqf
 *
 * Author: Glowbal
 * Advanced HandleDamage EH function.
 *
 * Arguments:
 * 0: Unit That Was Hit <OBJECT>
 * 1: Name Of Hit Selection <STRING>
 * 2: Amount Of Damage <NUMBER>
 * 3: Shooter <OBJECT>
 * 4: Projectile <STRING>
 * 5: Hit part index of the hit point <NUMBER>
 * 6: Shooter? <OBJECT>
 * 7: Current damage to be returned <NUMBER>
 *
 * Return Value:
 * None
 *
 * Public: No
 */


	//[_obj] call ace_medical_fnc_handleDamage_advancedSetDamage;

};

fn_fox_sayDefaultText = {

	_obj = _this select 0;

	if(!alive _obj)exitWith {};

	_textArray = [
			"Fuck you",
			"Awwwww",
			"Asshole",
			"Gonna kill you all"
	];

	_say = selectRandom _textArray;

	[
		[name _obj, _say, 2]
	] spawn BIS_fnc_EXP_camp_playSubtitles;

};


fn_fox_getAnswer = {

			_obj = _this select 0;

			_rate = _obj getVariable ["fox_interrogation_rate", 0];
			_will = _obj getVariable ["fox_interrogation_will", 80];

			if( _rate > _will)then{

					_answer = _obj getVariable ["fox_interrogation_answer", "0-7-8-2"];
					[
						[name _obj, _answer , 1]
					] spawn BIS_fnc_EXP_camp_playSubtitles;
			}else{
					[
						[name _obj, "Tell you nothing" , 1]
					] spawn BIS_fnc_EXP_camp_playSubtitles;
			};

};

fn_fox_checkBag = {

	_obj = _this select 0;

	if ( headgear _obj in ["mgsr_headbag"] ) then {
		false
	}else{
		if( "mgsr_headbag" in (items player + assignedItems player) ) then{

				if( isClass (configFile >> "cfgWeapons" >> "mgsr_headbag") ) then{
					true
				}else{
					false
				};
		}else{
			false
		}
	};
};

fn_fox_addBag = {

	_obj = _this select 0;

	removeHeadgear _obj;

	[_obj,"zipper"] call fn_fox_say3d;

	_obj addHeadgear "mgsr_headbag";

	player removeItem "mgsr_headbag";

};

fn_fox_say3d = {

	_object = _this select 0;
	_sound = _this select 1;

	_sound = format ["%1_%2",QUOTE(ADDON),_sound];
	[[ _object, _sound ], "say3d"] call BIS_fnc_MP;

};

fn_fox_switchMove = {

	_object = _this select 0;
	_animation = _this select 1;

	[[ _object, _animation ], "switchMove"] call BIS_fnc_MP;

};
