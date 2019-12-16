#!/bin/bash -x

echo "Welcome to TicTacToe"

user=-

declare -a cellValue

function getDefaultCellValue() {
	for (( i=1;i<10;i++ ))
	do
		cellValue[$i]=-
	done
}

function getBoardDisplayed() {
	echo "     |     |     "
	echo "  ${cellValue[1]}  |  ${cellValue[2]}  |  ${cellValue[3]}  "
	echo "_____|_____|_____"
	echo "     |     |     "
	echo "  ${cellValue[4]}  |  ${cellValue[5]}  |  ${cellValue[6]}  "
	echo "_____|_____|_____"
	echo "     |     |     "
	echo "  ${cellValue[7]}  |  ${cellValue[8]}  |  ${cellValue[9]}  "
	echo "     |     |     "
}

function getTossResult() {
	case $user in 
		X )
			echo "You will play first";;
		O )
			echo "Computer will play first";;
	esac
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
getTossResult
getBoardDisplayed
