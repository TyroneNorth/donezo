defmodule DonezoWeb.InputHelpers do
  use Phoenix.HTML

  def array_input(form, field) do
    values = Phoenix.HTML.Form.input_value(form, field) || [""]
    id = Phoenix.HTML.Form.input_id(form, field)
    _type = Phoenix.HTML.Form.input_type(form, field)

    content_tag :ol,
      id: container_id(id),
      class: "is-justify-content-flex-start",
      data: [index: Enum.count(values)] do
      values
      |> Enum.with_index()
      |> Enum.map(fn {value, index} ->
        new_id = id <> "_#{index}"

        _input_opts = [
          name: new_field_name(form, field),
          value: value,
          id: new_id,
          class: "form-control"
        ]

        form_elements(form, field, value, index)
      end)
    end
  end

  def array_add_button(form, field) do
    id = Phoenix.HTML.Form.input_id(form, field)

    content =
      form_elements(form, field, "", "__name__")
      |> safe_to_string

    data = [
      prototype: content,
      container: container_id(id)
    ]

    link("", to: "#", data: data, class: "add-form-field bi-plus-circle-fill is-size-2")
  end

  defp form_elements(form, field, value, index) do
    _type = Phoenix.HTML.Form.input_type(form, field)
    id = Phoenix.HTML.Form.input_id(form, field)
    new_id = id <> "_#{index}"

    input_opts = [
      name: new_field_name(form, field),
      value: value,
      id: new_id,
      class: "form-control textarea is-primary is-medium"
    ]

    content_tag :li, class: "columns ml-1", style: "width: 99.5%;" do
  [
    apply(Phoenix.HTML.Form, :textarea, [form, field, input_opts]),
    link("", to: "#", data: [id: new_id], title: "Remove", class: "remove-form-field bi-x-circle-fill is-size-2 level ml-3")
   ]
 end
  end

  defp container_id(id), do: id <> "_container"

  defp new_field_name(form, field) do
    Phoenix.HTML.Form.input_name(form, field) <> "[]"
  end
end
