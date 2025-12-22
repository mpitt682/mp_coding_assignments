#!/usr/bin/env bash

# Interactive menu to get responses for either a male or female cat at different times of day.
# Response options
declare -A fc_spec
fc_spec[6am]="Where's my breakfast? Gimme my dry food."
fc_spec[12pm]="I'm sleepy. Give me my heated cat bed."
fc_spec[6pm]="Where's my dinner?"
fc_spec[10pm]="I'm tired, I need my pillow."

declare -A mc_spec
mc_spec[6am]="I'm so HUNGRY. Where's my canned food?"
mc_spec[12pm]="Can't talk, sleeping."
mc_spec[6pm]="You're home, let me OUTSIDE!"
mc_spec[10pm]="I'm tired, time to snuggle."

declare -a fc_any=(
"Gimme your lap!"
"I need a back scratch"
"This food isn't FRESH. Gimme more"
"I will destroy you, purple mouse!"
"The service around here is abysmal.")

declare -a mc_any=(
"I need a full-body massage, STAT!"
"My butt itches, I need you to scratch it."
"If you need me I'll be under my hydrangea."
"Take THAT, Mr. Fluff!"
"Run run run, romp romp romp")

echo "Talking Cat Activity"
echo
echo "Please choose a gender for your cat:"

#Choose a gender and name the cat

select cat in "female" "male" "quit"
do
        case $cat in
                female) read -p "What would you like to name your female cat? " fc;
                while [[ -z $fc ]]; do
                        read -p "Your cat deserves a name, please provide one. " fc; done; break;;
                male) read -p "What would you like to name your male cat? " mc;
                while [[ -z $mc ]]; do
                        read -p "Your cat deserves a name, please provide one. " mc; done; break;;
                quit) break;;
                *) echo "I'm not sure what that is.";; 
        esac
done

# Choose a time of day to generate a response. The anytime slot chooses a command at random from each cat's array.
# Responses for each cat are specific to the time of day and the gender

echo
echo "What time of day is your cat talking?"

select time_slot in "6am" "12pm" "6pm" "10pm" "anytime" "quit"
do
	rand_num=$(( RANDOM % 5 ))
        case $time_slot in
		6am|12pm|6pm|10pm) if [[ ! -z $fc ]]; then echo $fc says \"${fc_spec["$time_slot"]}\";
		elif [[ ! -z $mc ]]; then echo $mc says \"${mc_spec["$time_slot"]}\"; else echo "Something went wrong"; fi;;
		
		anytime) if [[ ! -z $fc ]]; then echo $fc says \"${fc_any[rand_num]}\"; elif [[ ! -z $mc ]]; 
		then echo $mc says \"${mc_any[rand_num]}\"; else echo "Something went wrong."; fi;;
		
		quit) break;;
		*) echo "Not a valid option. Please choose a number from the menu.";;
        esac
done


