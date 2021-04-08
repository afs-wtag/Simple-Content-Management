class PagesController < ApplicationController
  layout 'admin'

  before_action :confirm_logged_in
  before_action :find_subject
  before_action :find_subjects, only: %i(edit update create new)
  before_action :set_page_count, only: %i(edit update new create)

  def index
    @pages = @subject.pages.sorted # calling class Page from page.rb
  end

  def show
    @page  = Page.find(params[:id])
  end

  def new
    @page = Page.new(:subject_id => @subject.id)
  end

  def create
    # instantiate a new object using foorm parameters
    @page = Page.new(page_params)
    if @page.save
      flash[:notice] = 'Page was created successfully....'
      redirect_to(pages_path(:subject_id => @subject.id)) # if save succeeds,redirect to the index action
    else
      render('new')
    end
  end

  def edit
    @page  = Page.find(params[:id])
  end

  def update
    # Find a new object using foorm parameters
    @page  = Page.find(params[:id])
    # save the subject
    if @page.update(page_params)
      flash[:notice] = 'Page was updated successfully.'
      redirect_to(pages_path(@page, :subject_id => @subject.id)) # if save succeeds,redirect to the index action
    else
      render('edit')
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    flash[:notice] = "page '#{@page.name}' destroyed successfully."
    redirect_to(pages_path(:subject_id => @subject.id))
  end

  private

  def page_params
    params.require(:page).permit(:subject_id, :name, :position, :visible, :permalink)
  end

  def find_subject
    @subject = Subject.find(params[:subject_id])
  end

  def find_subjects
    @subjects = Subject.sorted
  end

  def set_page_count
    @page_count = Page.count
    @page_count += 1 if params[:action] == 'new' || params[:action] == 'create'
  end
end
