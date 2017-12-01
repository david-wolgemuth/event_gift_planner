module ApplicationHelper
  
  def xmodal(modal_name, title: nil, start_visible: false, &block)
    render layout: 'application/xmodal', locals: {
        modal_name: modal_name, title: title, start_visible: start_visible
      } do
      capture(&block)
    end
  end

end
