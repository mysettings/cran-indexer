# frozen_string_literal: true

class HomesController < ApplicationController
  def index
    @r_packages = RPackage.all
  end
end
