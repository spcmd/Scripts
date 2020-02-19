#!/bin/bash

# dependencies: inkscape

# make black shogi pieces from white pieces (flip and rename)
w2b(){
    for file in *.svg; do inkscape --verb=EditSelectAll --verb=ObjectFlipVertically --verb=ObjectFlipHorizontally --verb=FileSave --verb=FileQuit $file; done && for file in *.svg; do mv $file ${file//White/Black} ; done
}

# rename xboard pieces to gshogi pieces (XBoard default = white, gshogi default = black)
x2g() {
mv WhiteAdvisor.svg silverB.svg
mv WhiteBishop.svg bishopB.svg
mv WhiteCrownedBishop.svg bishopPB.svg
mv WhiteCrownedRook.svg rookPB.svg
mv WhiteGoldKnight.svg knightPB.svg
mv WhiteGoldLance.svg lancePB.svg
mv WhiteGoldPawn.svg pawnPB.svg
mv WhiteGoldSilver.svg silverPB.svg
mv WhiteGold.svg goldB.svg
mv WhiteKing.svg kingB.svg
mv WhiteKnight.svg knightB.svg
mv WhiteLance.svg lanceB.svg
mv WhitePawn.svg pawnB.svg
mv WhiteRook.svg rookB.svg
}

g2x(){
mv silverB.svg WhiteAdvisor.svg
mv bishopB.svg WhiteBishop.svg
mv bishopPB.svg WhiteCrownedBishop.svg
mv rookPB.svg WhiteCrownedRook.svg
mv knightPB.svg WhiteGoldKnight.svg
mv lancePB.svg WhiteGoldLance.svg
mv pawnPB.svg WhiteGoldPawn.svg
mv silverPB.svg WhiteGoldSilver.svg
mv goldB.svg WhiteGold.svg
mv kingB.svg WhiteKing.svg
mv knightB.svg WhiteKnight.svg
mv lanceB.svg WhiteLance.svg
mv pawnB.svg WhitePawn.svg
mv rookB.svg WhiteRook.svg
}

help() {
 echo "usage: "
 echo "w2b      make black pieces from white pieces"
 echo "g2x      rename BLACK gshogi pieces to WHITE XBoard pieces (XBoard default = white, gshogi default = black)"
 echo "x2g      rename WHITE XBoard shogi pieces to BLACK gshogi pieces (XBoard default = white, gshogi default = black)"
}

case $1 in
    w2b) w2b ;;
    x2g) x2g ;;
    g2x) g2x ;;
    "") help ;;
    *) help ;;
esac
