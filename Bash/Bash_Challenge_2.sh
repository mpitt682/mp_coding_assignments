#!/usr/bin/env bash

#Random number face-off between two players

declare -i P1_wins=0
declare -i P2_wins=0

for i in {1..5}
do
	player1=$(( 1 + RANDOM % 10 ))
	player2=$(( 1 + RANDOM % 10 ))
	echo "ROUND $i: $player1 to $player2"
	if (( $player1 > $player2 ))
	then
        	echo "Player 1"
		((P1_wins++))
	elif (( $player1 < $player2 )) 
	then
        	echo "Player 2"
		((P2_wins++))       
	else
        	echo "It's a tie"
	fi
done

echo
if (( $P1_wins > $P2_wins ))
then
	echo "Player 1 Wins!"
elif (( $P2_wins > $P1_wins ))
then
	echo "Player 2 Wins!"
else
	echo "Tie Game!"
fi
