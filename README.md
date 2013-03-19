puppet-modules
==============

The [puppet-modules][1] project contains configuration management classes used
by the OpDemand cloud management system.

See [github][1] for the latest source.

To learn how to tame your AWS and Heroku infrastructure with the
OpDemand cloud management system, visit [OpDemand][2].

Using Puppet Modules
--------------------

These are standard [puppet][3] modules useful for general configuration
management tasks. In the OpDemand system, these puppet modules are used to
install and update standard software elements referenced by OpDemand templates.
(Puppet is not required by OpDemand; we use it to simplify our certified
templates, but you are free to use chef, shell scripting, or other approaches.)

The puppet modules have been made open source by [OpDemand][2]. Please read the
**LICENSE** file for details.

Documentation
-------------

Please see our [library][4] of technical resources and documentation. If
you have a question about using OpDemand that isn't yet answered there, please
let us know.

About OpDemand
--------------
[OpDemand][2] automates the development, deployment, and management of cloud
computing infrastructure. With GitHub integration, a simple toolbar, certified
templates, dynamic configuration, active monitoring, and support for puppet and
chef, OpDemand gives you control of your cloud.

[1]: https://github.com/opdemand/puppet-modules
[2]: http://www.opdemand.com/
[3]: https://puppetlabs.com/
[4]: http://www.opdemand.com/docs/
