module ShoutHelper

  def shout_form_for(content_class)
    form_for(Shout.new(content_type: content_class)) do |form|
      form.fields_for(:content) do |content_form|
        yield content_form
      end +
        form.hidden_field(:content_type) + form.submit("Shout")
    end
  end

  def reshout_button(shout)
    if current_user.reshouted?(shout)
      button_to "undo Reshout", unreshouts_shouts_path(shout), method: :delete
    else
      button_to "Reshout", reshouts_shout_path(shout), disabled: reshout_disabled?(shout)
    end
  end

  private

  def reshout_disabled?(shout)
    current_user.owns?(shout)
  end
end
