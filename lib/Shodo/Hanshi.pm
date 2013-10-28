package Shodo::Hanshi;
use strict;
use warnings;
use Text::MicroTemplate qw/render_mt encoded_string/;

sub new {
    my ($class, %args) = @_;
    my $self = bless { template => $args{template} }, $class;
    $self;
}

sub render {
    my ($self, $stash) = @_;
    my $tmpl = $self->{template} || $self->default_template;
    my $renderer = render_mt($self->header . $tmpl, $stash);
    return $renderer->as_string();
}

sub header {
    my $tmpl = <<'END';
? my ($stash) = @_;
? no strict qw/refs vars/;
? no warnings;
? ${$_} = encoded_string($stash->{$_}) for keys %$stash;
? use warnings;
? use strict qw/refs subs/;
END
    return $tmpl;
}

sub default_template {
    my $tmpl = <<'END';
## <?= $method ?> <?= $path ?>
? if ($description) {

<?= $description ?>

? }

### Request

```
<?= $method ?> <?= $path ?><?= $query || '' ?>

<?= $request_body ?>
```

### Response

```
Status: <?= $code ?>

<?= $response_body ?>
```

END
    return $tmpl;
}

1;
