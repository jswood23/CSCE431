# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :set_page, only: %i[show edit update destroy]
  before_action :check_has_access

  # GET /pages or /pages.json
  def index
    redirect_to('/manage_pages')
  end

  # GET /pages/1 or /pages/1.json
  def show
    redirect_to('/manage_pages')
  end

  # GET /pages/new
  def new
    redirect_to('/manage_pages', notice: 'Page creation unavailable')
  end

  # GET /pages/1/edit
  def edit; end

  # POST /pages or /pages.json
  def create
    redirect_to('/manage_pages', notice: 'Page creation unavailable')
  end

  # PATCH/PUT /pages/1 or /pages/1.json
  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to("/#{@page[:page_name]}", notice: 'Page was successfully updated.') }
        format.json { render(:show, status: :ok, location: @page) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @page.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /pages/1 or /pages/1.json
  def destroy
    redirect_to('/manage_pages', notice: 'Page deletion unavailable')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_page
    @page = Page.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def page_params
    params.require(:page).permit(:page_data, :page_name)
  end

  def check_has_access
    return true if admin?

    flash.alert = 'You do not have permission to access this.'
    redirect_to(home_path)
    false
  end
  # def event_params
  #   params.require(:event).permit(:event_name, :description, :passcode, :date, :points)
  # end
end
