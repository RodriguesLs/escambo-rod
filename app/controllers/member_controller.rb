class MemberController < ApplicationController
    before_action :authenticate_member!
    layout "member"
end
