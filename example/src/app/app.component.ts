import {AsyncPipe, NgIf, NgOptimizedImage} from "@angular/common";
import { Component } from '@angular/core';
import {CapacitorMedia} from "@cbechstein-digital/capacitor-media";
import {
  IonApp,
  IonButton,
  IonContent,
  IonGrid,
  IonHeader,
  IonRow,
  IonTitle,
  IonToolbar
} from "@ionic/angular/standalone";
import {Subject} from "rxjs";

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [IonApp, IonContent, IonHeader, IonToolbar, IonTitle, AsyncPipe, NgIf, IonGrid, IonRow, IonButton],
  templateUrl: './app.component.html',
})
export class AppComponent {
  private readonly thumbnailSourceSubject = new Subject<string>();
  readonly thumbnailSource$ = this.thumbnailSourceSubject.asObservable();

  getVideoThumbnailFromAlbum(albumName: string): void {
    CapacitorMedia.getLatestVideoThumbnailFromAlbum({ albumName: albumName })
      .then((result: { value: string }) => this.thumbnailSourceSubject.next(result.value))
      .catch((error: any) => console.warn(error));
  }
}
