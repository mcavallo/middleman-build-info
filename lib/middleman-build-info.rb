require "middleman-core"
require "middleman-build-info/version"

::Middleman::Extensions.register(:build_info) do
  require "middleman-build-info/extension"
  ::Middleman::BuildInfoExtension
end