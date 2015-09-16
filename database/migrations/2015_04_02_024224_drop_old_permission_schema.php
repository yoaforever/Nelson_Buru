<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class DropOldPermissionSchema extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::dropIfExists('users_webpages_roles');
		Schema::dropIfExists('webpages_memberships');		
		Schema::dropIfExists('webpages_oauthmemberships');
		Schema::dropIfExists('webpages_roles');			
	}

	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		//
	}

}
