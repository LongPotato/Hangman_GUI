
#==============================================================================#
# $Id: dialog.rb,v 1.4 2005/04/30 15:37:02 yuya Exp $
#==============================================================================#

require 'exerb/resource/base'

#==============================================================================#

module Exerb
  class Resource
  end # Resource
end # Exerb

#==============================================================================#

class Exerb::Resource::Dialog < Exerb::Resource::Base

  def initialize
    super()
  end

  def pack
    raise(NotImplementedError)
  end

end # Exerb::Resource::Dialog

#==============================================================================#
#==============================================================================#
