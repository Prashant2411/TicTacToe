#!/bin/bash -x

echo "Welcome to TicTacToe"

cellNumber=0
flag=0
winStatus=0

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

function getUserSymbol() {
	userSymbol=$(( RANDOM % 2 ))
	case $userSymbol in
		1 )
			comp=O
			user=X
			flag=0
			echo "You will play first";;
		0 )
			comp=X
			user=O
			flag=1
			echo "Computer will play first";;
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

function getWinCheck () {
        row=1
        column=1
        winStatus=0
        for (( i=1;i<4;i++ ))
        do
                if [[ ${cellValue[$row]} != " " && ${cellValue[$row]} == ${cellValue[(($row+1))]} && ${cellValue[$row]} == ${cellValue[(($row+2))]} ]]
                then
                        winStatus=1
                elif [[ ${cellValue[$column]} != " " && ${cellValue[$column]} == ${cellValue[(($column+3))]} && ${cellValue[$column]} == ${cellValue[(($column+6))]} ]]
                then
                        winStatus=1
                fi
                row=$(( $row + 3 ))
                column=$(( $column + 1 ))
        done
        i=1
        if [[ ${cellValue[$i]} != " " && ${cellValue[$i]} == ${cellValue[(($i+4))]} && ${cellValue[$i]} == ${cellValue[(($i+8))]} ]] || [[ ${cellValue[(($i+2))]} != " " && ${cellValue[(($i+2))]} == ${cellValue[(($i+4))]} && ${cellValue[(($i+2))]} == ${cellValue[(($i+6))]} ]]
        then
                winStatus=1
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
			elif [[ ${cellValue[(($i+8))]} == ${cellValue[(($i+4))]} && ${cellValue[$i]} == " " && ${cellValue[(($i+8))]} != " " ]]
		then
			cellValue[$i]=$comp
			cellNumber=$i
			winStatus=1
		elif [[ ${cellValue[(($i+2))]} == ${cellValue[(($i+4))]} && ${cellValue[(($i+6))]} == " " && ${cellValue[(($i+2))]} != " " ]]
		then
			cellValue[(($i+6))]=$comp
			cellNumber=$(( $i+6 ))
			winStatus=1
		elif [[ ${cellValue[(($i+2))]} == ${cellValue[(($i+6))]} && ${cellValue[(($i+4))]} == " " && ${cellValue[(($i+2))]} != " " ]]
		then
			cellValue[(($i+4))]=$comp
			cellNumber=$(( $i+4 ))
			winStatus=1
		elif [[ ${cellValue[(($i+4))]} == ${cellValue[(($i+6))]} && ${cellValue[(($i+2))]} == " " && ${cellValue[(($i+4))]} != " " ]]
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
		counter=0
		compInputStatus=0
		while [ $counter -lt 4 ]
		do
			corner=$(( RANDOM%4+1 ))
			case $corner in
				1 )	cellNumber=1;;
				2 )	cellNumber=3;;
				3 )	cellNumber=7;;
				4 )	cellNumber=9;;
			esac
			((counter++))
			valid=$( isValidCell $cellNumber )
			if [ $valid -eq 1 ]
			then
				cellValue[$cellNumber]=$comp
				compInputStatus=1
				break
			fi
		done
	fi
}

function getEmptyCenter () {
	valid=$( isValidCell 5 )
	if [[ $valid -eq 1 && $compInputStatus -eq 0 ]]
	then
		cellValue[5]=$comp
		compInputStatus=1
	fi
}

function getEmptySides () {
	if [ $compInputStatus -eq 0 ]
	then
		counter=0
		while [ $counter -lt 4 ]
		do
			corner=$(( RANDOM%4+1 ))
			case $corner in
				1 )	cellNumber=2;;
				2 )	cellNumber=4;;
				3 )	cellNumber=6;;
				4 )	cellNumber=8;;
			esac
			((counter++))
			valid=$( isValidCell $cellNumber )
			if [ $valid -eq 1 ]
			then
				cellValue[$cellNumber]=$comp
				compInputStatus=1
				break
			fi
		done
	fi
}

function getWinner () {
	cellNumber=$1
	getWinCheck
	if [[ $winStatus -eq 1 ]]
	then
		echo "${cellValue[$cellNumber]} is winner"
		exit
	fi
}

function main() {
	getDefaultCellValue
	getUserSymbol
	getBoardDisplayed
	for (( j=1;j<6;j++ ))
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
				((j--))
			fi
		fi
		if [ $flag -eq 1 ]
		then
			echo "Computer's Turn "
			getWinRowChecked
			getWinColumnChecked
			getWinDiagonalChecked
			getEmptyCorner
			getEmptyCenter
			getEmptySides
			getBoardDisplayed
			getWinner $cellNumber
			flag=0
		fi
	done
	if [ $j == 6 ]
	then
		echo "Match Tied"
	fi
}

main
