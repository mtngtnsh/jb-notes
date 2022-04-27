# Helm

>Helm is the best way to find, share, and use software built for Kubernetes. Helm helps you manage Kubernetes applications — Helm Charts help you define, install, and upgrade even the most complex Kubernetes application.

## GitHub

- [helm/helm](https://github.com/helm/helm/releases)

## Docs

- [Docs Home](https://helm.sh/docs/)
- [Helm Command](https://helm.sh/docs/helm/helm/)

## Install Helm

```
$ brew install helm
```

## Helm: Three Big Concepts

1. Chart:
    >A Chart is a Helm package. It contains all of the resource definitions necessary to run an application, tool, or service inside of a Kubernetes cluster. Think of it like the Kubernetes equivalent of a Homebrew formula, an Apt dpkg, or a Yum RPM file.
2. Repository:
    >A Repository is the place where charts can be collected and shared. It's like Perl's CPAN archive or the Fedora Package Database, but for Kubernetes packages.
3. Release:
    >A Release is an instance of a chart running in a Kubernetes cluster. One chart can often be installed many times into the same cluster. And each time it is installed, a new release is created. Consider a MySQL chart. If you want two databases running in your cluster, you can install that chart twice. Each one will have its own release, which will in turn have its own release name.

## Chart(TODO)
