#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		units[] = {};
		weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"ace_interaction"};
	};
};


class CfgFunctions
{
	class ADDON
	{
		class functions
		{
			file="\fox_interrogation\functions";
			class init
			{
				postInit=1;
			};
		};
	};
};


class CfgVehicles{
	class Man;
	class CAManBase: Man	{

		class Attributes{
		    class Fox_Attr_Land_Laptop_unfolded_F{
		        //--- Mandatory properties
		        displayName = "Is interragtion available"; // Name assigned to UI control class Title
		        tooltip = ""; // Tooltip assigned to UI control class Title
		        property = VNAME(action); // Unique config property name saved in SQM
		        control = "Checkbox"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes
		        expression = "if(_value)then{ _this setVariable ['fox_interrogation_action',_value,TRUE]; } else{ _this setVariable ['fox_interrogation_action',_value,FALSE] }";
		        defaultValue = "false";
		        unique = 0; // When 1, only one entity of the type can have the value in the mission (used for example for variable names or player control)
		        validate = "none"; // Validate the value before saving. Can be "none", "expression", "condition", "number" or "variable"
		        condition = "object"; // Condition for attribute to appear (see the table below)
		        typeName = "BOOL"; // Defines data type of saved value, can be STRING, NUMBER or BOOL. Used only when control is "Combo", "Edit" or their variants
		      };

			  class Fox_Attr_laptop_file2_text{
				  //--- Mandatory properties
				  displayName = "Answer"; // Name assigned to UI control class Title
				  tooltip = "Text"; // Tooltip assigned to UI control class Title
				  property = VNAME(text); // Unique config property name saved in SQM
				  control = "Edit"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes
				  expression = "_this setVariable ['fox_interrogation_answer',_value,TRUE];";
				  defaultValue = "I dont know";
				  unique = 0; // When 1, only one entity of the type can have the value in the mission (used for example for variable names or player control)
				  validate = "none"; // Validate the value before saving. Can be "none", "expression", "condition", "number" or "variable"
				  condition = "object"; // Condition for attribute to appear (see the table below)
				  typeName = "STRING"; // Defines data type of saved value, can be STRING, NUMBER or BOOL. Used only when control is "Combo", "Edit" or their variants
			  };

		};//Attributes


		class ACE_Actions{
					class ACE_Head{
								class TRIPLES(ADDON,head,punch){
									displayName="Punch";
									condition="[_target] call fn_fox_canInterrogate";
									statement="[_target,""head""] call fn_fox_punch";
									showDisabled=0;
									priority=1;
									distance=2;
									icon="\fox_interrogation\ui\punch.paa";
								};

							class TRIPLES(ADDON,head,putonbag){
								displayName="Put on bag";
								condition="[_target] call fn_fox_checkBag AND [_target] call fn_fox_canInterrogate";
								statement="[_target] call fn_fox_addBag";
								showDisabled=0;
								priority=1;
								distance=2;
								icon="\fox_interrogation\ui\bag.paa";
							};
					};

					class ACE_MainActions{
						class TRIPLES(ADDON,torso,sitdown){
							displayName="In chair";
							condition = "[_target] call fn_fox_chairCheck";
							statement="[_target] call fn_fox_chair";
							showDisabled=0;
							priority=1;
							distance=2;
							icon="\fox_interrogation\ui\chair.paa";
						};
						class TRIPLES(ADDON,torso,answer){
							displayName="Get answers";
							condition = "[_target] call fn_fox_canInterrogate";
							statement="[_target] call fn_fox_getAnswer";
							showDisabled=0;
							priority=1;
							distance=2;
							icon="\fox_interrogation\ui\talk.paa";
						};
					};
					class ACE_Torso{
							class TRIPLES(ADDON,torso,punch){
								displayName="Punch";
								condition="[_target] call fn_fox_canInterrogate";
								statement="[_target,""body""] call fn_fox_punch";
								showDisabled=0;
								priority=1;
								distance=2;
								icon="\fox_interrogation\ui\punch.paa";
							};
					};

					class ACE_ArmRight{
									class TRIPLES(ADDON,armright,knife){
										displayName="Use knife";
										condition="[_target] call fn_fox_canInterrogate";
										statement="[_target,""hand_r""] call fn_fox_knife";
										showDisabled=0;
										priority=1;
										distance=2;
										icon="\fox_interrogation\ui\knife.paa";
									};
					};
					class ACE_ArmLeft{
									class TRIPLES(ADDON,armleft,knife){
										displayName="Use knife";
										condition="[_target] call fn_fox_canInterrogate";
										statement="[_target,""hand_l""] call fn_fox_knife";
										showDisabled=0;
										priority=1;
										distance=2;
										icon="\fox_interrogation\ui\knife.paa";
									};
					};
		};
		};
	};




class CfgSounds{
	sounds[]={"fox_interrogation_hurt1","fox_interrogation_hurt2"};
	class fox_interrogation_hurt1{

		name="fox_interrogation_hurt1";
		sound[]= {"\fox_interrogation\sounds\hurt1.ogg",1,1};
		titles[]={};

	};
	class fox_interrogation_hurt2{

		name="fox_interrogation_hurt2";
		sound[]= {"\fox_interrogation\sounds\hurt2.ogg",1,1};
		titles[]={};

	};

	class fox_interrogation_zipper{

		name="fox_interrogation_zipper";
		sound[]= {"\fox_interrogation\sounds\zipper.ogg",1,1};
		titles[]={};

	};
};
