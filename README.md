barely-functional
=====

Curiously robust<sup>1</sup> functional<sup>2</sup> implementations for BASH.

<sup>1</sup> read, "hazardous"
<sup>2</sup> read, "stateful, imperative"

## Usage

Clone the repository

    git clone https://github.com/jonnystorm/barely-functional.git

then source.

    source barely-functional/functional.sh

Hack, hack, hack...

    jstorm@trivius:~$ elem 2 "1 2" "3 4" "5 6"
    3 4

    jstorm@trivius:~$ map "elem 2" "1 2" "3 4" "5 6"
    "2"
    "4"
    "6"

    jstorm@trivius:~$ map "elem 2" "1 2" "3 4" "5 6" | map "add 1"
    "3"
    "5"
    "7"

    jstorm@trivius:~$ map "elem 2" "1 2" "3 4" "5 6" | map "add 1" | reduce add 0
    15

    jstorm@trivius:~$ append_42 { local e=$1; local acc=$2; echo "\"$e 42\"
    > $acc"; };
    jstorm@trivius:~$ reduce append_42 "" "1 2" "3 4" "5 6"
    "5 6 42"
    "3 4 42"
    "1 2 42"

