#!/bin/bash -x

echo "Welcome to TicTacToe"

declare -a cellValue

function getDefaultCellValue() {
	for (( i=1;i<10;i++ ))
	do
		cellValue[$i]=-
	done
}

function getUserSymbol() {
	userSymbol=$(( RANDOM % 2 ))
	case $userSymbol in
		1 )
			user=X;;
		0 )
			user=O;;
	esac
	echo "You are assigned: " $user
}

getDefaultCellValue
getUserSymbol
