// Copyright (c) Microsoft. All rights reserved.
using MudBlazor;
namespace ClientApp.Pages;

public sealed partial class Index
{
    private readonly Image[] _images = new Image[]
    {};
}

internal readonly record struct Image(string Src, string Alt);
