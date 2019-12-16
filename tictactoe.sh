#!/bin/bash -x

echo "Welcome to TicTacToe"

winStatusRow=0
winStatusCol=0
winStatusDiag=0

declare -a cellValue

function getDefaultCellValue() {
	for (( i=1;i<10;i++ ))
	do
		cellValue[$i]=" "
	done
}

function getBoardDisplayed() {
	echo -e "     |     |     \n  ${cellValue[1]}  |  ${cellValue[2]}  |  ${cellValue[3]} \n_____|_____|_____"
	echo -e "     |     |     \n  ${cellValue[4]}  |  ${cellValue[5]}  |  ${cellValue[6]} \n_____|_____|_____"
	echo -e "     |     |     \n  ${cellValue[7]}  |  ${cellValue[8]}  |  ${cellValue[9]} \n     |     |     "
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

function isValidCell() {
	case ${cellValue[$1]} in
		" " )
			cellValid=1;;
		* )
			cellValid=0;;
	esac
	echo $cellValid
}

function getRowCheck () {
	for (( i=1;i<10;i=$(( $i+3 )) ))
	do
		if [[ ${cellValue[$i]} != " " && ${cellValue[$i]} == ${cellValue[(($i+1))]} && ${cellValue[$i]} == ${cellValue[(($i+2))]} ]]
		then
			echo 1
		fi
	done
}

function getColumnCheck () {
	for (( i=1;i<4;i++ ))
	do
		if [[ ${cellValue[$i]} != " " && ${cellValue[$i]} == ${cellValue[(($i+3))]} && ${cellValue[$i]} == ${cellValue[(($i+6))]} ]]
		then
			echo 1
		fi
	done
}

function getDiagonalCheck () {
	i=1
	if [[ ${cellValue[$i]} != " " && ${cellValue[$i]} == ${cellValue[(($i+4))]} && ${cellValue[$i]} == ${cellValue[(($i+8))]} ]]
	then
		echo 1
	fi

	i=3
	if [[ ${cellValue[$i]} != " " && ${cellValue[$i]} == ${cellValue[(($i+2))]} && ${cellValue[$i]} == ${cellValue[(($i+4))]} ]]
	then
		echo 1
	fi
}

function main() {
	getDefaultCellValue
	getUserSymbol
	getTossResult
	getBoardDisplayed
	while true
	do
		read -p "Enter the cell number between 1-9: " cellNumber
		validCell=$( isValidCell $cellNumber )
		if [ $validCell -eq 1 ]
		then
			cellValue[$cellNumber]=$user
			getBoardDisplayed
			counter=$(( $counter+1 ))
			winStatusRow=$( getRowCheck )
			winStatusCol=$( getColumnCheck )
			winStatusDiag=$( getDiagonalCheck )
			if [[ $winStatusRow -eq 1 || $winStatusCol -eq 1 || $winStatusDiag -eq 1 ]]
			then
				echo "${cellValue[$cellNumber]} is winner"
				break
			fi
		else
			echo "Enter valid cell number"
		fi
	done
}

main
