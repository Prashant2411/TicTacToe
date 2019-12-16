#!/bin/bash -x

echo "Welcome to TicTacToe"

declare -a cellValue

function getDefaultCellValue() {
	for (( i=1;i<10;i++ ))
	do
		cellValue[$i]=-
	done
}

getDefaultCellValue
