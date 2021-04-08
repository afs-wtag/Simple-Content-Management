class SectionsController < ApplicationController
  layout 'admin'

  before_action :confirm_logged_in
  def index
    @sections = Section.sorted # calling class Page from page.rb
  end

  def show
    @section  = Section.find(params[:id])
  end

  def new
    @section = Section.new
    @section_count = Section.count + 1
    @pages = Page.sorted
  end

  def create
    # instantiate a new object using foorm parameters
    @section = Section.new(section_params)
    # save the subject
    if @section.save
      flash[:notice] = 'The Section was created successfully....'
      redirect_to(sections_path) # if save succeeds,redirect to the index action
    else
      @section_count = Section.count + 1
      @pages = Page.sorted
      render('new')
    end
  end

  def edit
    @section = Section.find(params[:id])
    @section_count = Section.count
    @pages = Page.sorted
  end

  def update
    # Find a new object using foorm parameters
    @section = Section.find(params[:id])
    # save the subject
    if @section.update(section_params)
      flash[:notice] = 'Section was updated successfully.'
      redirect_to(sections_path(@section)) # if save succeeds,redirect to the index action
    else
      @section_count = Section.count
      @pages = Page.sorted
      render('edit')
    end
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy
    flash[:notice] = "Section '#{@section.name}' destroyed successfully."
    redirect_to(sections_path)
  end

  private

  def section_params
    params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
  end
end
