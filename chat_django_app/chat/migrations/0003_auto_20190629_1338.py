# Generated by Django 2.1.5 on 2019-06-29 13:38

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('chat', '0002_chatlog_concatenated_classes'),
    ]

    operations = [
        migrations.AlterField(
            model_name='chatlog',
            name='message_class',
            field=models.CharField(choices=[('H', 'HATESPEECH'), ('U', 'UNCLASSIFIED'), ('O', 'OFFENSIVE'), ('N', 'NORMAL')], max_length=1),
        ),
    ]