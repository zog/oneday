{additional_field, required_field, collect_setting_data, format_setting_data} = SettingsEditor.Utils

get_handler = (type) ->
  type: type
  match: (v) -> v is type or v.type is type
  fake_value: -> new Date()
  save: (hidden) ->
    data = collect_setting_data(type, hidden, 'required')
    hidden.value = format_setting_data(data)

  additional_fields: (value, hidden) ->
    on_update = => @save(hidden)
    fields = $(required_field hidden)
    additional_field 'required', value, hidden, fields, on_update
    fields

SettingsEditor.handlers.push(get_handler 'date')
SettingsEditor.handlers.push(get_handler 'datetime')
SettingsEditor.handlers.push(get_handler 'time')
