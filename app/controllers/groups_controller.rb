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
      #link to creator and make them admin
      @group.set_admin(current_user)
      respond_to do |format|
        format.html { redirect_to @group }
        format.js
      end
    else
      respond_to do |format|
        flash[:notice] = {error: ["a group with this groupname already exists"]}
        format.html { redirect_to new_group_path }
        format.js { render template: 'groups/group_error.js.erb'}
      end
    end
  end

  def join
    @group=Group.find_by(slug: params[:slug])
    #if
    respond_to do |format|
      format.html { redirect_to @group }
      format.js
    end
  end

  # def update
  #   group = Group.find_by(slug: params[:slug])
  #   group.update(group_params)
  #   redirect_to group
  # end

  def show
    @group = Group.find_by(slug: params[:slug])
    @message = Message.new
    @role = Role.find_or_create_by(group_id: @group.id, user_id: current_user.id) #sets default to "member"
    @members = @group.get_members.pluck(:username)
    @admin = @group.get_admin.pluck(:username)
  end

  private

    def group_params
      params.require(:group).permit(:groupname)
    end
end
