class RedactorInput < SimpleForm::Inputs::Base
  def input
    input_html_options.merge!({ class: 'redactor' })
    @builder.text_area(attribute_name, input_html_options)
  end
end