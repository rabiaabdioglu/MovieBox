# MovieBox

MovieBox, SwiftUI kullanılarak geliştirilen, kullanıcıların film beğenip beğenmedikleri bir film uygulamasıdır. Kullanıcılar kayıt olabilir, giriş yapabilir, film listesine ulaşabilir, filmleri beğenebilir veya beğenmekten vazgeçebilirler. Ayrıca kendi profil bilgilerini görüntüleyip güncelleyebilirler.

---

## Çalışma Senaryosu

Bu proje, Study Case kapsamında SwiftUI, MVVM ve Networking pratikleri yapmak için hazırlanmıştır.

---

## Uygulama Özellikleri ve Gerçekleştirilenler

| Özellik                                 | Durum          |
|----------------------------------------|----------------|
| Kullanıcı Kayıt ve Giriş İşlemleri     | ✔ Gerçekleştirildi |
| Token ile Oturum Yönetimi               | ✔ Gerçekleştirildi (Token saklama & yönetim) |
| Film Listesini Getirme                  | ✔ Gerçekleştirildi |
| Film Detayını Getirme                   | ✔ Gerçekleştirildi |
| Film Beğenme / Beğenmekten Vazgeçme    | ✔ Gerçekleştirildi |
| Beğenilen Filmleri Getirme              | ✔ Gerçekleştirildi |
| Kullanıcı Bilgilerini Güncelleme        | ✔ Gerçekleştirildi |

---

## Kullanılan Teknolojiler

- **SwiftUI** — UI tasarımı için  
- **MVVM Mimarisi** — Kodun ayrıştırılması ve sürdürülebilirlik için  
- **URLSession** — Networking katmanı olarak  
- **Combine** — ViewModel ile View arasındaki veri akışında 
- **Token Yönetimi** — Oturumun devamlılığı için 

---

## Proje Mimarisi

- **Model:** API’den gelen JSON verilerinin temsil edildiği `User`, `Movie` gibi struct’lar  
- **ViewModel:** API servis çağrılarını yapan ve UI’a uygun veri hazırlayan `AuthViewModel`, `MovieViewModel`, `UserViewModel` gibi sınıflar  
- **View:** SwiftUI ile hazırlanmış, kullanıcı giriş, kayıt, film listesi, film detay ve profil güncelleme ekranları  
- **Service:** Ağ isteklerinin gerçekleştirildiği `APIService` sınıfı  

---

## API İsimleri ve Kullanımı

- `register user` — Kullanıcı kaydı için  
- `login user` — Kullanıcı girişi için  
- `get current user` — Oturum açan kullanıcının bilgilerini almak için  
- `get all movies` — Film listesini çekmek için  
- `get movies by id` — Film detaylarını almak için  
- `like movie` — Film beğenme işlemi için  
- `unlike movie` — Film beğenmekten vazgeçmek için  
- `get liked movies` — Beğenilen filmleri listelemek için  
- `get liked movie by ids` - Detay sayfada beğenilme durumuna bakmak için kullanıldı. 
- `update user` — Kullanıcı profilini güncellemek için  

---

## Sınıflar ve Fonksiyonlar

### AuthService - MovieService - UserService 
- Ağ isteklerini organize eder.  
- Fonksiyonlar: `register`, `login`, `getCurrentUser`, `fetchMovies`, `fetchMovieById`, `likeMovie`, `unlikeMovie`, `getLikedMovies`, `updateUser`.

### AuthViewModel.swift  
- Kullanıcı kimlik doğrulama ve oturum yönetimi.  
- Fonksiyonlar: `registerUser()`, `loginUser()`, `logout()`, `fetchCurrentUser()`.

### MovieViewModel.swift  
- Film listesi ve beğenme işlemlerinin yönetimi.  
- Fonksiyonlar: `loadMovies()`, `likeMovie()`, `unlikeMovie()`, `fetchLikedMovies()`.

### UserViewModel.swift  
- Kullanıcı profil bilgilerini yönetir.  
- Fonksiyonlar: `fetchUserProfile()`, `updateProfile()`.

### Views (SwiftUI)  
- LoginView, RegisterView, ProfileView, MovieListView, MovieDetailView gibi ekranlar kullanıcı arayüzünü sağlar.




