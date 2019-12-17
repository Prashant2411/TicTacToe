#!/bin/bash -x

echo "Welcome to TicTacToe"

cellNumber=0
flag=0
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
	echo -e "     |     |     \n  ${cellValue[7]}  |  ${cellValue[8]}  |  ${cellValue[9]} \n     |     |     \n"
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
			comp=O
			user=X
			flag=0;;
		0 )
			comp=X
			user=O
			flag=1;;
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

function getWinRowChecked () {
	winStatus=0
	for (( i=1;i<10;i=$(( $i + 3 )) ))
	do
		if [[ ${cellValue[$i]} == ${cellValue[(($i+1))]} && ${cellValue[$i]} != " " && ${cellValue[(($i+2))]} == " " ]]
		then
			cellValue[(($i+2))]=$comp
			cellNumber=$(( $i+2 ))
			winStatus=1
		elif [[ ${cellValue[$i]} == ${cellValue[(($i+2))]} && ${cellValue[$i]} != " " && ${cellValue[(($i+1))]} == " " ]]
		then
			cellValue[(($i+1))]=$comp
			cellNumber=$(( $i+1 ))
			winStatus=1
		elif [[ ${cellValue[(($i+1))]} == ${cellValue[(($i+2))]} && ${cellValue[(($i+1))]} != " " && ${cellValue[$i]} == " " ]]
		then
			cellValue[$i]=$comp
			cellNumber=$i
			winStatus=1
		fi
	done
}

function getWinColumnChecked () {
	echo "$winStatus"
	if [ $winStatus -eq 0 ]
	then
		for (( i=1;i<4;i++ ))
		do
			if [[ ${cellValue[$i]} == ${cellValue[(($i+3))]} && ${cellValue[$i]} != " " && ${cellValue[(($i+6))]} == " " ]]
			then
				cellValue[(($i+6))]=$comp
				cellNumber=$(( $i+6 ))
				winStatus=1
			elif [[ ${cellValue[$i]} == ${cellValue[(($i+6))]} && ${cellValue[$i]} != " " && ${cellValue[(($i+3))]} == " " ]]
			then
				cellValue[(($i+3))]=$comp
				cellNumber=$(( $i+3 ))
				winStatus=1
			elif [[ ${cellValue[(($i+3))]} == ${cellValue[(($i+6))]} && ${cellValue[(($i+3))]} != " " && ${cellValue[$i]} == " " ]]
			then
				cellValue[$i]=$comp
				cellNumber=$i
				winStatus=1
			fi
		done
	fi
}

function getWinDiagonalChecked () {
	echo "$winStatus"
	if [ $winStatus -eq 0 ]
	then
			i=1
			if [[ ${cellValue[$i]} == ${cellValue[(($i+4))]} && ${cellValue[(($i+8))]} == " " && ${cellValue[$i]} != " " ]]
			then
				cellValue[(($i+8))]=$comp
				cellNumber=$(( $i+8 ))
				winStatus=1
			elif [[ ${cellValue[$i]} == ${cellValue[(($i+8))]} && ${cellValue[(($i+4))]} == " " && ${cellValue[$i]} != " " ]]
			then
				cellValue[(($i+4))]=$comp
				cellNumber=$(( $i+4 ))
				winStatus=1
			elif [[ ${cellValue[(($i+8))]} == ${cellValue[(($i+4))]} && ${cellValue[$i]} == " " && ${cellValue[$i]} != " " ]]
			then
				cellValue[$i]=$comp
				cellNumber=$i
				winStatus=1
			elif [[ ${cellValue[(($i+2))]} == ${cellValue[(($i+4))]} && ${cellValue[(($i+6))]} == " " && ${cellValue[(($i+2))]} != " " ]]
			then
				cellValue[(($i+6))]=$comp
				cellNumber=$(( $i+6 ))
				winStatus=1
			elif [[ ${cellValue[(($i+2))]} == ${cellValue[(($i+6))]} && ${cellValue[(($i+4))]} == " " && ${cellValue[$i]} != " " ]]
			then
				cellValue[(($i+4))]=$comp
				cellNumber=$(( $i+4 ))
				winStatus=1
			elif [[ ${cellValue[(($i+4))]} == ${cellValue[(($i+6))]} && ${cellValue[(($i+2))]} == " " && ${cellValue[$i]} != " " ]]
			then
				cellValue[(($i+2))]=$comp
				cellNumber=$(( $i+2 ))
				winStatus=1
			fi
	fi
}

function getEmptyCorner () {
	if [ $winStatus -eq 0 ]
	then
		valid=0
		while [ $valid == 0 ]
		do
			corner=$(( RANDOM%4+1 ))
			case $corner in
				1 )	cellNumber=1;;
				2 )	cellNumber=3;;
				3 )	cellNumber=7;;
				4 )	cellNumber=9;;
			esac
			valid=$( isValidCell $cellNumber )
			if [ $valid -eq 1 ]
			then
				cellValue[$cellNumber]=$comp
			fi
		done
	fi
}

function getComputerInput () {
	if [ $winStatus -eq 0 ]
	then
		cellNumber=$(( RANDOM % 9 + 1 ))
		validCell=$( isValidCell $cellNumber )
		if [[ $validCell -eq 1 ]]
		then
			cellValue[$cellNumber]=$comp
		else
			getComputerInput
		fi
	fi
}

function getWinner () {
	cellNumber=$1
	winStatusRow=$( getRowCheck )
	winStatusCol=$( getColumnCheck )
	winStatusDiag=$( getDiagonalCheck )
	if [[ $winStatusRow -eq 1 || $winStatusCol -eq 1 || $winStatusDiag -eq 1 ]]
	then
		echo "${cellValue[$cellNumber]} is winner"
		exit
	fi
}

function main() {
	getDefaultCellValue
	getUserSymbol
	getTossResult
	getBoardDisplayed
	for (( j=1;j<10;j++ ))
	do
		if [ $flag -eq 0 ]
		then
			read -p "Enter the cell number between 1-9: " cellNumber
			validCell=$( isValidCell $cellNumber )
			if [ $validCell -eq 1 ]
			then
				echo "User's Turn "
				cellValue[$cellNumber]=$user
				counter=$(( $counter+1 ))
				getBoardDisplayed
				getWinner $cellNumber
				flag=1
			else
				echo "Enter valid cell number"
				((i--))
			fi
		fi
		if [ $flag -eq 1 ]
		then
			echo "Computer's Turn "
			getWinRowChecked
			getWinColumnChecked
			getWinDiagonalChecked
			getEmptyCorner
			getBoardDisplayed
			getWinner $cellNumber
			flag=0
		fi
	done
}

main
