module Reform
  class Form < Contract
    self.representer_class = Reform::Representer.for(:form_class => self)
    self.object_representer_class = Reform::ObjectRepresenter.for(:form_class => self)

    require "reform/form/validate"
    include Validate # extend Contract#validate with additional behaviour.
    require "reform/form/sync"
    include Sync
    require "reform/form/save"
    include Save
    require "reform/form/prepopulate"
    include Prepopulate

    require "reform/form/multi_parameter_attributes"
    include MultiParameterAttributes # TODO: make features dynamic.

  private
    def aliased_model
      # TODO: cache the Expose.from class!
      @_aliased_model ||= self.class.expose_class.new(:model => model)
    end

    def self.expose_class
      @_expose_class ||= Reform::Expose.from(representer_class)
    end


    require "reform/form/scalar"
    extend Scalar::Property # experimental feature!


    # DISCUSS: should that be optional? hooks into #validate, too.
    require "reform/form/changed"
    register_feature Changed
    include Changed
  end
end
