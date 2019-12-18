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

function getNextMoveWinStatus() {
        if [[ ${cellValue[$1]} == ${cellValue[$2]} && ${cellValue[$1]} != " " && ${cellValue[$3]} == " " && ${cellValue[$1]} == $4  && $winStatus -eq 0 ]]
        then
                cellValue[$3]=$comp
                cellNumber=$3
                winStatus=1
        elif [[ ${cellValue[$1]} == ${cellValue[$3]} && ${cellValue[$1]} != " " && ${cellValue[$2]} == " " && ${cellValue[$1]} == $4  && $winStatus -eq 0 ]]
        then
                cellValue[$2]=$comp
                cellNumber=$2
                winStatus=1
        elif [[ ${cellValue[$3]} == ${cellValue[$2]} && ${cellValue[$2]} != " " && ${cellValue[$1]} == " " && ${cellValue[$3]} == $4  && $winStatus -eq 0 ]]
        then
                cellValue[$1]=$comp
                cellNumber=$1
                winStatus=1
        fi
}

function getNextMoveWinCheck() {
        getNextMoveWinStatus 1 2 3 $1
        getNextMoveWinStatus 4 5 6 $1
        getNextMoveWinStatus 7 8 9 $1
        getNextMoveWinStatus 1 4 7 $1
        getNextMoveWinStatus 2 5 8 $1
        getNextMoveWinStatus 3 6 9 $1
        getNextMoveWinStatus 1 5 9 $1
        getNextMoveWinStatus 3 5 7 $1
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
			winStatus=0
			getNextMoveWinCheck $comp
                        getNextMoveWinCheck $user
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
