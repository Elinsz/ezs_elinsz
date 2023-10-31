# @since 1.0.0
module EIS

  # Method to load SKUI into a given namespace - ensuring EIS can be
  # distributed easily within other projects.
  #
  # @example
  #   module Example
  #     load File.join( skui_path, 'EIS', 'embed_eis.rb' )
  #     ::EIS.embed_in( self )
  #     # EIS module is now available under Example::EIS
  #   end
  #
  # @param [Module] context
  #
  # @return [Boolean]
  # @since 1.0.0
  def self.embed_in( context )
    # Temporarily rename existing root EIS.
    Object.send( :const_set, :EIS_Temp, EIS )
    Object.send( :remove_const, :EIS )
    # Load EIS for this EIS implementation.
    path = File.dirname( __FILE__ )
    # In SU2019, with Ruby 2.0 the __FILE__ constant return an UTF-8 string with
    # incorrect encoding label which will cause load errors when the file path
    # contain multi-byte characters. This happens when the user has non-english
    # characters in their username.
    path.force_encoding( "UTF-8" ) if path.respond_to?( :force_encoding )
    core = File.join( path, 'core.rb' )
    loaded = require( core )
    # One can only embed EIS into one context per SKUI installation. This is
    # because `require` prevents the files to be loaded multiple times.
    # This should not be an issue though as an extension that implements EIS
    # should only use the EIS version it distribute itself.
    if loaded
      # Move EIS to the target context.
      context.send( :const_set, :EIS, EIS )
      Object.send( :remove_const, :EIS )
      true
    else
      false
    end
  ensure
    # Restore root SKUI and clean up temp namespace.
    Object.send( :const_set, :EIS, EIS_Temp )
    Object.send( :remove_const, :EIS_Temp )
  end

end # module
