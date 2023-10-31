# encoding: UTF-8
#
# Elinsz 3D - parametric design for modular systems
# Copyright 2023 Elinsz 3D - elinsz - elinsz3d.com.br
#------------------------------------------------------------------------------
#
# Elinsz 3D uses Sketchup UI (SKUI) https://github.com/thomthom/SKUI
# SKUI is licensed under the MIT License - Copyright (c) 2014 Thomas Thomassen

Sketchup.require 'sketchup'
Sketchup.require 'extensions'

module EIS
	module Elinsz

		VERSION = "1.1.1"
		T = LanguageHandler.new( "elinsz.strings" )
		elinszExtension = SketchupExtension.new('Elinsz', File.join('Eis_Elinsz','App','ElinszLoader'))
		elinszExtension.description = "Parametric design for modular systems - www.elinsz3d.com.br"
		elinszExtension.version = VERSION
		elinszExtension.creator = "Elinsz 3D"
		elinszExtension.copyright = "Elinsz 3D - www.elinsz3d.com.br - 2022"
		Sketchup.register_extension elinszExtension, true

	end
end
