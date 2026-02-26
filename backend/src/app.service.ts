import { Injectable } from '@nestjs/common';
import { PrismaService } from './prisma/prisma.service';
import * as bcrypt from 'bcrypt';
import { randomUUID } from 'crypto';

@Injectable()
export class AppService {
  constructor(private prisma: PrismaService) {}

  async getProfileCount() {
    const count = await this.prisma.profile.count();
    return { ok: true, profileCount: count };
  }

  async createTestProfile() {
    // 1) auth_user + profile aynı id ile (1:1) oluşturacağız
    const id = randomUUID();

    // AuthUser artık email + password zorunlu olduğu için test verisi üretelim
    const email = `test_${Date.now()}@example.com`;
    const passwordHash = await bcrypt.hash('Test1234!', 10);

    // auth_users tablosuna
    await this.prisma.authUser.create({
      data: {
        id,
        email,
        password: passwordHash,
        provider: 'local',
      },
    });

    // profiles tablosuna (aynı id)
    const profile = await this.prisma.profile.create({
      data: {
        id,
        fullName: 'Test User',
        goalType: 'lose_weight',
        activityLevel: 'medium',
        weightKg: 70,
        targetWeightKg: 65,
        heightCm: 170,
      },
    });

    return { ok: true, createdProfile: profile };
  }
}
