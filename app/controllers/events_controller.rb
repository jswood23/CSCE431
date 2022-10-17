# frozen_string_literal: true

class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show; end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to events_path, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update; end

  def delete; end

  def destroy; end

  private

  def set_event
    @event = Event.find(params[id])
  end

  def event_params
    params.require(:event).permit(:event_name, :description, :date, :points, :passcode)
  end
end
