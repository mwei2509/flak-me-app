class GroupsController < ApplicationController

  def index
    @group = Group.new
    @groups = Group.all
  end

  def new
    if request.referrer.split("/").last == "groups"
      flash[:notice] = nil
    end
    @group = Group.new
  end

  def edit
    @group = Group.find_by(slug: params[:slug])
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      respond_to do |format|
        format.html { redirect_to @group }
        format.js
      end
    else
      respond_to do |format|
        flash[:notice] = {error: ["a group with this topic already exists"]}
        format.html { redirect_to new_group_path }
        format.js { render template: 'groups/group_error.js.erb'} 
      end
    end
  end

  def update
    group = Group.find_by(slug: params[:slug])
    group.update(group_params)
    redirect_to group
  end

  def show
    @group = Group.find_by(slug: params[:slug])
    @message = Message.new
  end

  private

    def group_params
      params.require(:group).permit(:topic)
    end
end
