# Easy template

# About

> The easy-template is just a simple interface for manage simple set of
templates. Some features:

* List available templates;
* Copy template to specific paths;

# Install

> Easy-template is installed inside the home directory and it is exported via
bashrc. To install it, just type:

```
./setup.sh --install
```

> If you want to remove easy-template, type:

```
./setup.sh --uninstall
```

# How to

> To list the available templates, you have two options:

```
easy-template # In no paramater is passed, the default operation is list
easy-template -l
```

> First, you need the template name (use -l). Create a template in the current
path:

```
easy-template -c [template_name]
```

> If you want to create a template with a specific name:

```
easy-template -c [template_name] -n [name]
```

> To create a template in a different path:

```
easy-template -c [template_name] -p [path]
```

