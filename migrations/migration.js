var SC_V1 = artifacts.require("MyContract");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(MyContract);
};
