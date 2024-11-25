/// Represents social media type
enum SocialMediaType {
  GOOGLE,
  FACEBOOK,
  INSTAGRAM,
  TELEGRAM,
  TIKTOK,
  // Reserved for internal usage
  APPLE
}

extension SocialMediaTypeExtensions on SocialMediaType {
  String get name {
    switch (this) {
      case SocialMediaType.GOOGLE:
        return "Google";
      case SocialMediaType.FACEBOOK:
        return "Facebook";
      case SocialMediaType.INSTAGRAM:
        return "Instagram";
      case SocialMediaType.TELEGRAM:
        return "Telegram";
      case SocialMediaType.TIKTOK:
        return "TikTok";
      case SocialMediaType.APPLE:
        return "Apple";
    }
  }
}
