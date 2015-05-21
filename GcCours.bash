#! /bin/bash
#
#
#  Auteurs : Le.NoX ;o)
#  M@il : le . nox @ free . fr
#  https://github.com/xonel/GcCours
Version="0.0.1"
#
#  Licence: GNU GPL
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#


F_help() {
	echo "./GcCours gpx NUM_GARMIN_COURS"
	echo "./GcCours -a NUM_GARMIN_COURS"
	exit
}


F_FolderWorks() {
	if [ -d ./$Vcours ]; then
	
	else
		mkdir ./$Vcours
		cd ./$Vcours
	fi
}

F_SingleType() {
	cd ./$Vcours & wget http://connect.garmin.com/proxy/course-service-1.0/$Vtype/course/$Vcours
	mv $Vcours $Vcours.Vtype
}

F_MultiType() {
	Vtype="tcx"
	F_SingleType
	
	Vtype="gpx"
	F_SingleType
	
	Vtype="fit"
	F_SingleType
	
	Vtype="json"
	F_SingleType
	
	Vtype="gpolyline"
	F_SingleType
}

M_Main(){
	Vtype=$1
	
	case $VMain
		in
           tcx|gpx|fit|json|gpolyline ) #
		       #########################################################
				F_FolderWorks
				F_SingleType
             ;;

          -a) # 
		       #########################################################
				F_FolderWorks
				F_MultiType
             ;;
                         
          -v) #
		       #########################################################
		       echo "Version : "$Version
             ;;
                         
          -h) #
		       #########################################################
				F_help
             ;;

          *)   # anything else
		       #########################################################
            echo "\"$VMain\" NO VALID ENTRY"
            ;;
        esac
}

if [ -z "$1" ]; then #-z string is null // -n string is not null
	VMain=$1
	Vcours=$2
	M_Main
else
	F_help
fi
