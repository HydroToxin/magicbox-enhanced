module BootstrapHelper
  def bootstrap_radio_button(form, field, value, text, options = {})
    id = "#{form.object_name}_#{field}_#{value}"
    options[:class] ||= ''
    options[:class] += ' btn-check'
    form.radio_button(field, value, options.merge(id: id, autocomplete: :off)) +
    form.label(field, text, class: 'btn btn-outline-primary', for: id)
  end
end