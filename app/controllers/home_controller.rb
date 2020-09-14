class HomeController < ApplicationController
  def render_template
    rendered_template = CustomLiquid.new.render_nested(params[:template], params[:data].to_unsafe_h)
    render json: { renderedTemplate: rendered_template }
  end
end