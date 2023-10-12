const Sequelize = require('sequelize')

const mysql = require("mysql2/promise");
const UserModel = require("../models/User");
const AssignmentModel = require("../models/Assignment");

require('dotenv').config();
// const database = process.env.database
// const user = process.env.username
// const password = process.env.password
// const dialectName = process.env.dialect
// const host = process.env.host
const database = process.env.DB_NAME
const user = process.env.DB_USER
const password = process.env.DB_PASSWORD
const host = process.env.DB_HOST
const dialectName = process.env.DB_DIALECT

const sequelize = new Sequelize(
  database, user, password, 
  {
    dialect: dialectName,
    host: host
  })

const User = UserModel(sequelize);
const Assignment = AssignmentModel(sequelize);

const syncDatabase = async () => {
  await sequelize.sync({ alter: true });
  console.log("Models synchronized successfully.");
};

const createDatabase = async () => {
  const connection = await mysql.createConnection({
    host: host,
    user: user,
    password: password,
  });
  await connection.query(`CREATE DATABASE IF NOT EXISTS \`${database}\`;`);
};

module.exports = {
  sequelize,
  createDatabase,
  syncDatabase,
  User,
  Assignment,
};