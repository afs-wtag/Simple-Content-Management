class SubjectsController < ApplicationController
  layout 'admin'

  before_action :confirm_logged_in

  def index
    logger.debug('*** Testing the logger ***')
    @subjects = Subject.sorted
  end

  def show
    @subject  = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new({ name: 'Default' })
    @subject_count = Subject.count + 1
  end

  def create
    # instantiate a new object using foorm parameters
    @subject = Subject.new(subject_params)
    # save the subject
    if @subject.save
      flash[:notice] = 'Subject was created successfully....'
      redirect_to(subjects_path) # if save succeeds,redirect to the index action
    else
      @subject_count = Subject.count + 1
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
    @subject_count = Subject.count
  end

  def update
    # Find a new object using foorm parameters
    @subject = Subject.find(params[:id])
    # save the subject
    if @subject.update(subject_params)
      flash[:notice] = 'Subject updated successfully.'
      redirect_to(subjects_path(@subject)) # if save succeeds,redirect to the index action
    else
      @subject_count = Subject.count
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
    flash[:notice] = "Subject '#{@subject.name}' destroyed successfully."
    redirect_to(subjects_path)
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :position, :visible, :created_at)
  end
end
