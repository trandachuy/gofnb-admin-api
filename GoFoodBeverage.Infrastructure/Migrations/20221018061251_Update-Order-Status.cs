﻿using Microsoft.EntityFrameworkCore.Migrations;
using System;
using System.IO;

namespace GoFoodBeverage.Infrastructure.Migrations
{
    public partial class UpdateOrderStatus : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            var sqlFile = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, @"Migrations/Scripts/s16-update-order-status.sql");
            var script = File.ReadAllText(sqlFile);
            migrationBuilder.Sql(script);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            
        }
    }
}
