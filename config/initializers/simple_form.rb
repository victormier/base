# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.wrappers :default, :class => :input,
    :hint_class => :field_with_hint, :error_class => :field_with_errors do |b|

    # Calculates placeholders automatically from I18n
    # You can also pass a string as f.input :placeholder => "Placeholder"
    b.use :placeholder

    # Calculates maxlength from length validations for string inputs
    b.optional :maxlength

    # Calculates pattern from format validations for string inputs
    b.optional :pattern

    # Calculates min and max from length validations for numeric inputs
    b.optional :min_max

    # Calculates readonly automatically from readonly attributes
    b.optional :readonly

    ## Inputs
    b.use :label_input
    b.use :hint,  :wrap_with => { :tag => :span, :class => :hint }
    b.use :error, :wrap_with => { :tag => :span, :class => :error }
  end

  # Custom wrapper
  config.wrappers :with_controls, :class => 'control-group',
    :hint_class => :field_with_hint, :error_class => :field_with_errors do |b|
    b.use :html5
    b.use :placeholder
    b.use :label, class: 'control-label'
    b.use :tag => 'div', :class => 'controls' do |ba|
      ba.use :input
      ba.use :error, :tag => :span, :class => :'help-inline'
      ba.use :hint,  :tag => :span, :class => :'help-block'
    end
  end

  # The default wrapper to be used by the FormBuilder.
  config.default_wrapper = :default

  # Define the way to render check boxes / radio buttons with labels.
  config.boolean_style = :nested

  # Default class for buttons
  config.button_class = 'btn'

  # Default tag used for error notification helper.
  config.error_notification_tag = :div

  # CSS class to add for error notification helper.
  config.error_notification_class = 'alert alert-error'

  # You can define the class to use on all labels. Default is nil.
  config.label_class = 'control-label'

  # Remove asterisk from required fields
  config.label_text = lambda { |label, required| "#{label}" }

  # Tell browsers whether to use default HTML5 validations (novalidate option).
  # Default is enabled.
  config.browser_validations = false
end
